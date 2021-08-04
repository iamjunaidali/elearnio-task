# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API V1 Courses', type: :request do
  describe '#index' do
    let(:params) do
      {
        self_assignable: true
      }
    end
    let!(:course) { create(:course) }
    let!(:self_assignable_course) { create(:course, self_assignable: true) }

    context 'when no filter provided' do
      it 'returns all records' do
        get api_v1_courses_path
        expect(response).to have_http_status(:ok)
        expect(parsed_response['data'][0]['attributes']['name']).to eq(course.name)
        expect(parsed_response['data'][0]['attributes']['coach']).to eq(course.coach.name)
      end
    end

    context 'when self_assignable filter provided' do
      it 'returns only self_assignable records' do
        get '/api/v1/courses?filter[self_assignable]=true'
        expect(response).to have_http_status(:ok)
        expect(parsed_response['data'][0]['attributes']['name']).to eq(self_assignable_course.name)
        expect(parsed_response['data'][0]['attributes']['coach']).to eq(self_assignable_course.coach.name)
      end
    end
  end

  describe '#create' do
    let!(:coach) { create(:coach) }

    let(:params) do
      '{"data":{
          "type":"courses",
          "attributes":{
             "name":"CS401"
          },
          "relationships":{
             "coach":{
                "data":{
                   "type":"coaches",
                   "id":"' + coach.id.to_s + '"
                }
             }
          }
        }
      }'
    end

    context 'when params are perfect' do
      it 'creates a course' do
        headers = { 'content-type': 'application/vnd.api+json' }
        post api_v1_courses_path, params: params, headers: headers
        expect(response).to have_http_status(:created)
        expect(parsed_response['data']['attributes']['name']).to eq('CS401')
        expect(parsed_response['data']['attributes']['coach']).to eq(coach.name)
      end
    end

    context 'when coach is missing' do
      let(:params) do
        '{"data":{
            "type":"courses",
            "attributes":{
               "name":"CS401"
            }
          }
        }'
      end

      it 'throws an exception' do
        headers = { 'content-type': 'application/vnd.api+json' }
        post api_v1_courses_path, params: params, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['errors'][0]['detail']).to eq('coach - must exist')
      end
    end
  end

  describe '#show' do
    let!(:course) { create(:course) }

    context 'when correct id passed' do
      it 'returns the record' do
        get api_v1_course_path(course.id)
        expect(response).to have_http_status(:ok)
        expect(parsed_response['data']['attributes']['name']).to eq(course.name)
        expect(parsed_response['data']['attributes']['coach']).to eq(course.coach.name)
      end
    end

    context 'when incorrect id passed' do
      it 'returns error' do
        get api_v1_course_path(-9999)
        expect(response).to have_http_status(:not_found)
        expect(parsed_response['errors'][0]['detail']).to eq('The record identified by -9999 could not be found.')
      end
    end
  end
end
