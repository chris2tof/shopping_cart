class PromotionsController < ApplicationController

	def index
		@promotions = Promotion.all
	end

	def new
		@promotion = Promotion.new
		@items = Item.all
	end

	def create
		item = Item.find(params[:item_id]) rescue nil
		if item
			@promotion = item.promotions.build(params[:promotion])
		else
			@promotion = Promotion.new(params[:promotion])
		end
		if @promotion.save
			redirect_to	promotions_url
		else
			render :new
		end
	end

end