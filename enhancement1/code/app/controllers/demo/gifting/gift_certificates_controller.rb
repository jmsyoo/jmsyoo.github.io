# frozen_string_literal: true
module Demo
    module Gifting
      class GiftCertificatesController < ApiController
        # POST /api/gifting/gift_certificates/verify_serials
        def verify_serials
          serials = params.require(:serials)
          result  = VerifySerialsService.new(serials: serials).call
          render json: VerifySerialsSerializer.new(result).as_json, status: :ok
        rescue ActionController::ParameterMissing => e
          render json: ErrorSerializer.validation(e.param), status: :bad_request
        rescue ArgumentError => e
          render json: ErrorSerializer.unprocessable(e.message), status: :unprocessable_entity
        end
  
        # POST /api/gifting/gift_certificates/mark_sold
        def mark_sold
          payload = MarkSoldParams.normalize!(params, current_user&.id)
          result  = MarkSoldService.new(payload).call
          render json: MarkSoldSerializer.new(result).as_json, status: :ok
        rescue ActionController::ParameterMissing => e
          render json: ErrorSerializer.validation(e.param), status: :bad_request
        rescue ArgumentError => e
          render json: ErrorSerializer.unprocessable(e.message), status: :unprocessable_entity
        end
      end
    end
  end
  