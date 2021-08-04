# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API V1 Activities', type: :request do
  describe '#index' do
    let!(:activity) { create(:activity) }

    context 'when no filter provided' do
      it 'returns all records' do
        get api_v1_activities_path
        expect(response).to have_http_status(:ok)
        expect(parsed_response['data'][0]['attributes']['name']).to eq(activity.name)
      end
    end
  end

  describe '#create' do
    let!(:course) { create(:course) }

    let(:params) do
      '{"data":{
          "type":"activities",
          "attributes":{
             "name":"Quiz 1"
          },
          "relationships":{
             "course":{
                "data":{
                   "type":"courses",
                   "id":"' + course.id.to_s + '"
                }
             }
          }
        }
      }'
    end

    context 'when params are perfect' do
      it 'creates an activity' do
        headers = { 'content-type': 'application/vnd.api+json' }
        post api_v1_activities_path, params: params, headers: headers
        expect(response).to have_http_status(:created)
        expect(parsed_response['data']['attributes']['name']).to eq('Quiz 1')
      end
    end

    context 'when course is missing' do
      let(:params) do
        '{"data":{
            "type":"activities",
            "attributes":{
               "name":"Quiz 1"
            }
          }
        }'
      end

      it 'throws an exception' do
        headers = { 'content-type': 'application/vnd.api+json' }
        post api_v1_activities_path, params: params, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
        expect(parsed_response['errors'][0]['detail']).to eq('course - must exist')
      end
    end
  end

  describe '#show' do
    let!(:activity) { create(:activity) }

    context 'when correct id passed' do
      it 'returns the record' do
        get api_v1_activity_path(activity.id)
        expect(response).to have_http_status(:ok)
        expect(parsed_response['data']['attributes']['name']).to eq(activity.name)
      end
    end

    context 'when incorrect id passed' do
      it 'returns error' do
        get api_v1_activity_path(-9999)
        expect(response).to have_http_status(:not_found)
        expect(parsed_response['errors'][0]['detail']).to eq('The record identified by -9999 could not be found.')
      end
    end
  end
end
