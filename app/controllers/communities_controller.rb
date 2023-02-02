class CommunitiesController < ApplicationController

    def index
        communities = Community.all
        render json: communities, except: [:created_at, :updated_at],include: [:users, :posts => { except: [:created_at, :updated_at],include: [:likes, :comments] } ], 
        status: :ok
    end

    def show
        community = Community.find_by(id: params[:id])
        render json: community, except:[:created_at, :updated_at],include: [:users, :posts => { except: [:created_at, :updated_at],include: [:likes, :comments] } ], status: :ok
    end
end
