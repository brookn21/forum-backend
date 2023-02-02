class UsersController < ApplicationController

    def profile 
        auth_token = request.headers['Authenticate']
        if auth_token
            token = JWT.decode( auth_token, ENV['JWT_TOKEN'])[0]
            user = User.find_by( id: token['user'] )
            render json: user, except: [:created_at, :updated_at], include: [:communities, :posts ], status: :ok
        else
            return nil
        end
    end

    def show
        user = User.find_by(id: params[:id])
        render json: user, except:[:created_at, :updated_at ], include: [:communities, :posts], status: :ok
    end

    def create 
        user = User.create(user_params)
        # user_params[:first_name, :email, :last_name, :username, :password]
        if user.valid?
            # user.save
            render json: user, except: [:created_at, :updated_at], status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # def update 
    #     user = User.find_by(id: params[:id])
    #     if user 
    #         if user_params[:username]
    #         user.username = user_params[:username]
    #         end
    #         if user_params[:img]
    #         user.img = user_params[:img]
    #         end
    #         if user_params[:bio]
    #         user.body = user_params[:bio]
    #         end
    #         if user.valid?
    #             user.save
    #             render json: user, except:[:created_at, :updated_at ], include: [:communities, :posts], status: :ok
    #         else
    #             render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    #         end
    #     else
    #         render json: {errors:["User Not Found"]}, status: :not_found
    #     end
    # end

    private

    def user_params
        params.require( :user ).permit( :email, :password, :first_name, :last_name, :username, :bio, :img)
    end

    # :password_confirmation,     "password_confirmation":"12345_Bb",

end
