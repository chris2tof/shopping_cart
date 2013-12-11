class	CartRowsController < ApplicationController

	def destroy
		row = CartRow.find(params[:id])
		row.destroy
		redirect_to cart_url(@cart)
	end

	def decrease
		row = CartRow.find(params[:id])
		if row.quantity == 1
			row.destroy
		else
			row.quantity -= 1
			row.save
		end
		redirect_to cart_url(@cart)
	end

	def increase
		row = CartRow.find(params[:id])
		row.quantity += 1
		row.save
		redirect_to cart_url(@cart)
	end

end