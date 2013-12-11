class ItemsController < ApplicationController
	
	def index
		@items = Item.all.order_by([:ref, :asc])
	end

	def show
		@item = Item.find(params[:id]) rescue nil
		unless @item
			redirect_to items_url, error: t(:not_found, object: "Item")
		end
	end

	def new
		@item = Item.new
	end

	def create
		@item = Item.new(params[:item])
		if @item.save
			redirect_to items_url
		else
			render :new
		end
	end

	def edit
		@item = Item.find(params[:id]) rescue nil
		unless @item
			redirect_to items_url, error: t(:not_found, object: "Item")
		end
	end

	def update
		@item = Item.find(params[:id]) rescue nil
		if @item
			if @item.update_attributes(params[:item])
				redirect_to items_url
			else
				@item = Item.new(params[:item])
				render :edit
			end
		else
			redirect_to items_url, error: t(:not_found, object: "Item")
		end
	end

	def destroy
		item = Item.find(params[:id]) rescue nil
		if item
			item.destroy
			redirect_to items_url
		else
			redirect_to items_url, error: t(:not_found, object: "Item")
		end
	end

	def add_to_cart
		item = Item.find(params[:id]) rescue nil
		if item
			row = @cart.cart_rows.detect{|row| row.item_ref.eql?(item.ref) }
			if row
				row.increment
			else
				@cart.cart_rows.create(item_id: item.id, quantity: 1)
			end
			redirect_to cart_url(@cart.id)
		else
			redirect_to items_url, error: t(:not_found, object: "Item")
		end
	end

end