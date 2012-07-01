class DealsController < ApplicationController

	def index
		@deal_email = DealEmail.new
    @deals = Deal.order("purchased DESC")
    respond_to do |format|
	    format.html
	    format.json do
	      render json: @deals.map { |t| view_context.deal_for_mustache(t) }
	    end
	  end
  end

  def show
    @deal = deal.find(params[:id])   
  end
end
