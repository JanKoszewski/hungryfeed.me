class DealsController < ApplicationController

	def index
    @deals = Deal.order("created_at DESC").limit(10)
    @deals = @deals.offset((params[:page].to_i-1)*10) if params[:page].present?
    respond_to do |format|
	    format.html
	    format.json do
	      render json: @deals.map { |t| view_context.deal_for_mustache(t) }
	    end
	  end
  end
end
