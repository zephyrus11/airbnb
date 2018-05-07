class UsersController < Clearance::UsersController

    def new
    @user = user_from_params
    render template: "users/new"
      end

    def create
        @user = user_from_params

        if @user.save
          
          sign_in @user
          redirect_back_or url_after_create
        else
          render template: "users/new"
        end
    end

     def user_from_params
        email = user_params.delete(:email)
        password = user_params.delete(:password)
        first_name = user_params.delete(:first_name)
        last_name = user_params.delete(:last_name)
        phone = user_params.delete(:phone)
        gender = user_params.delete(:gender)
        birthdate = user_params.delete(:birthdate)
        country = user_params.delete(:country)
        avatar = user_params.delete(:avatar)

        Clearance.configuration.user_model.new(user_params).tap do |user|
          user.email = email
          user.password = password
          user.first_name = first_name
          user.last_name = last_name
          user.phone = phone
          user.gender = gender
          user.birthdate = birthdate
          user.country = country
          user.avatar = avatar
        end
     end

    def edit
      @user = current_user
    end

    def update
          @user = current_user
          if @user.update(permit_params)
              redirect_to :back
          else
              render 'edit'
          end
      end

     private

     def user_params
   		params[Clearance.configuration.user_parameter] || Hash.new
      end

      def permit_params
          params.require(:user).permit(:first_name,:last_name,:email,:password,:phone,:gender,:birthdate, :country, :avatar)
      end 
    
end