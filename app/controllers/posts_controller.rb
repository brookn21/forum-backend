class PostsController < ApplicationController

    def index
        posts = Post.all
        render json: posts, except: [:created_at, :updated_at, :community_id, :user_id ],include: [:user, :community, :comments, :likes], status: :ok
    end

    def show
        post = Post.find_by(id: params[:id])
        render json: post, except:[:created_at, :updated_at, :community_id, :user_id ], include: [:community, :user, :comments, :likes], status: :ok
    end

    def create 
        post = Post.new(post_params)
        if post.valid?
            post.save
            render json: post, except: [:created_at, :community_id, :user_id ], include: [:community, :user], status: :created
        else
            render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update 
        post = Post.find_by(id: params[:id])
        if post 
            if post_params[:title]
            post.title = post_params[:title]
            end
            if post_params[:img]
            post.img = post_params[:img]
            end
            if post_params[:body]
            post.body = post_params[:body]
            end
            if post.valid?
                post.save
                render json: post, except:[:created_at, :updated_at, :community_id, :user_id ], include: [:community, :user, :comments], status: :ok
            else
                render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: {errors:["Post Not Found"]}, status: :not_found
        end
    end

    def destroy
        post = Post.find_by( id: params[:id])
        if post
            post.destroy
            head :no_content
        else
            render json: { errors: ['user_comm not found.']}, status: :not_found
        end
    end

    private

    def post_params
        params.require( :post ).permit( :title, :img, :user_id, :community_id, :body)
    end
end
