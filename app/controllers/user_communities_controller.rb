class UserCommunitiesController < ApplicationController

    def index
        user_comms = UserCommunity.all
        render json: user_comms, except: [:created_at, :updated_at, :user_id], include: [:community, :user], status: :ok
    end
    
    def show
        user_comm = UserCommunity.find_by(user_id: params[:user_id])
        render json: user_comm, except:[:created_at, :updated_at, :community_id, :user_id ], include: [:community, :user], status: :ok
    end

    def create
        user_comm = UserCommunity.new( user_community_params )
        if user_comm.valid?
            user_comm.save
            render json: user_comm, except: [:created_at, :updated_at], include: [:community, :user], status: :created
        else
            render json: { errors: user_comm.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        user_comm = UserCommunity.find_by( id: params[:id])
        if user_comm
            user_comm.destroy
            head :no_content
        else
            render json: { errors: ['user_comm not found.']}, status: :not_found
        end
    end
    
    private

    def user_community_params
        params.require( :user_community ).permit(:user_id, :community_id) 
    end

end
