class ItemsController < ApplicationController
	
	def index
		@items = Item.all
	end

	def show
		@item = Item.find(params[:id]) rescue nil
		unless @item
			redirect_to items_url, error: t('item.not_found')
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

	def add_to_cart
		item = Item.find(params[:id]) rescue nil
		if item
			row = @cart.cart_rows.detect{|row| row.item_ref.eql?(item.ref) }
			if row
				row.increment
			else
				@cart.cart_rows.create(item_id: item.id, quantity: 1)
			end
			redirect_to show_cart_url(@cart.id)
		else
			redirect_to items_url, error: t('item.not_found')
		end
	end

end