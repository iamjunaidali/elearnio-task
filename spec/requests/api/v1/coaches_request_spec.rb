# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API V1 Coaches', type: :request do
  describe '#index' do
    let!(:coach) { create(:coach) }

    context 'when call index' do
      it 'returns all records' do
        get api_v1_coaches_path
        expect(response).to have_http_status(:ok)
        expect(parsed_response['data'][0]['attributes']['name']).to eq(coach.name)
      end
    end
  end

  describe '#create' do
    let!(:coach) { create(:coach) }

    let(:params) do
      '{"data":{
          "type":"coaches",
          "attributes":{
             "name":"Bella"
          }
        }
      }'
    end

    context 'when params are perfect' do
      it 'creates a coach' do
        headers = { 'content-type': 'application/vnd.api+json' }
        post api_v1_coaches_path, params: params, headers: headers
        expect(response).to have_http_status(:created)
        expect(parsed_response['data']['attributes']['name']).to eq('Bella')
      end
    end
  end

  describe '#show' do
    let!(:coach) { create(:coach) }

    context 'when correct id passed' do
      it 'returns the record' do
        get api_v1_coach_path(coach.id)
        expect(response).to have_http_status(:ok)
        expect(parsed_response['data']['attributes']['name']).to eq(coach.name)
      end
    end

    context 'when incorrect id passed' do
      it 'returns error' do
        get api_v1_coach_path(-9999)
        expect(response).to have_http_status(:not_found)
        expect(parsed_response['errors'][0]['detail']).to eq('The record identified by -9999 could not be found.')
      end
    end
  end

  describe '#delete' do
    let!(:coach_with_course) { create(:coach) }
    let!(:course) { create(:course, coach: coach_with_course) }
    let!(:coach_without_course) { create(:coach) }

    context 'when coach without course' do
      it 'deletes the record' do
        delete api_v1_coach_path(coach_without_course.id)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when coach with courses' do
      it 'deletes the record' do
        delete api_v1_coach_path(coach_with_course.id)
        expect(response).to have_http_status(:no_content)
        # it will ensure that we have assigned another coach in case of deletion
        # Only if the deleted coach has a course.
        expect(course.reload.coach.name).to eq(coach_without_course.name)
      end
    end

    context 'when a single coach with courses' do
      it 'prevents deletion of the record' do
        Course.destroy_all
        Coach.destroy_all
        course = create(:course)
        delete api_v1_coach_path(course.coach.id)
        expect(response).to have_http_status(:unprocessable_entity)
        # it will ensure that if we have only once coach with a course.
        # it will not delete
        expect(parsed_response['errors'][0]['title']).to eq('Cannot delete Coach with course')
      end
    end
  end
end
