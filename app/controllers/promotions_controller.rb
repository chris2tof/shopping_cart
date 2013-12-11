class PromotionsController < ApplicationController

	def index
		@promotions = Promotion.all.order_by([:ref, :asc])
	end

	def show
		@promotion = Promotion.find(params[:id]) rescue nil
		unless @promotion
			redirect_to items_url, error: t(:not_found, object: "Promotion")
		end
	end

	def new
		@promotion = Promotion.new
		@items = Item.all
	end

	def create
		if params[:promotion][:on].eql?("item_")
			item = Item.find(params[:item_id]) rescue nil
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

	def edit
		@promotion = Promotion.find(params[:id]) rescue nil
		unless @promotion
			redirect_to promotions_url, error: t(:not_found, object: "Promotion")
		end
		@items = Item.all
	end

	def update
		@promotion = Promotion.find(params[:id]) rescue nil
		if @promotion
			if @promotion.update_attributes(params[:promotion])
				redirect_to promotions_url
			else
				@promotion = Promotion.new(params[:promotion])
				render :edit
			end
		else
			redirect_to promotions_url, error: t(:not_found, object: "Promotion")
		end
	end

	def destroy
		promotion = Promotion.find(params[:id]) rescue nil
		if promotion
			promotion.destroy
			redirect_to promotions_url
		else
			redirect_to promotions_url, error: t(:not_found, object: "Promotion")
		end
	end

end