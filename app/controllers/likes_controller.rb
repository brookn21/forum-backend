class LikesController < ApplicationController

    def index
        likes = Like.all
        render json: likes, except: [:created_at, :community_id], status: :created
    end

    def create 
        like = Like.new(like_params)
        if like.valid?
            like.save
            render json: like, except: [:created_at, :community_id], status: :created
        else
            render json: { errors: like.errors.full_messages }, status: :unprocessable_entity
        end
    end


    private

    def like_params
        params.require( :like ).permit( :post_id, :img, :user_id)
    end
end
