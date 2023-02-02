class CommentsController < ApplicationController

    def index
        comments = Comment.all
        render json: comments, except: [:created_at, :updated_at, :post_id, :user_id ],include: [:user, :post], status: :ok
    end

    def show
        comment = Comment.find_by(id: params[:id])
        render json: comment, except:[:created_at, :updated_at, :post_id, :user_id ], include: [:post, :user], status: :ok
    end

    def create 
        comment = Comment.new(comment_params)
        if comment.valid?
            comment.save
            render json: comment, except: [:created_at, :post_id, :user_id ],include: [:post, :user], status: :created
        else
            render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # def destroy
    #     comment = UserCommunity.find_by( id: params[:id])
    #     if user_comm
    #         user_comm.destroy
    #         head :no_content
    #     else
    #         render json: { errors: ['user_comm not found.']}, status: :not_found
    #     end
    # end

    private

    def comment_params
        params.require( :comment ).permit( :user_id, :post_id, :body)
    end
end
