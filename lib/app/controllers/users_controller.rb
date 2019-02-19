class UsersController < ApplicationController

  before_filter :user_logged_in?

  def new_admin
    @admin = User.new
  end

  def create_admin

    @admin = User.where(:email => params[:email])

    if(@admin[0])
      if(@admin[0].role & User::IS_ADMIN > 0 )
        flash[:notice] = "Already an admin!! "
      else
        @admin.update_all(:role => User::IS_MEMBER | User::IS_ADMIN)
        flash[:notice] = "Added as an admin"
      end
    else
      @admin = User.new(:name => params[:name], :email => params[:email], :password=> params[:password],:isDeleted=>FALSE,:role => User::IS_ADMIN)
      #@admin = User.new(params[:admin],:isDeleted=>FALSE,:role => User::IS_ADMIN)
      @admin.save
      flash[:notice] = "Created admin" #{params[:name]}
  end
    redirect_to(:action => 'view_admins')
  end

  def view_admins

      @admins = User.where("isDeleted = ? and role & ? > 0",FALSE,User::IS_ADMIN)

  end

  def delete_admins
    del_admin = User.where( id: params[:to_be_deleted_admins])

    del_admin.each do |a|
      if (a.email == session[:email] )

        flash[:notice] = "Can't Delete yourself"
      elsif (a.email == 'superUser@libsys.com')

        flash[:notice] =  "Can't Delete SuperAdmin"

      elsif (a.role & User::IS_MEMBER > 0)
        a.update(:role => User::IS_MEMBER)
      else
        reservations = Reservation.where(:user_id => a.id,:dateReturned => NIL)

        if(reservations.any?)
          flash[:notice] = "Can't Delete. Return Checked out books first!!"
        else
          a.update(:isDeleted => TRUE)
          flash[:notice] = "Delete Successful!!"

        end
      end
      #@del_admin.update_all(:isDeleted => TRUE)
    end
    redirect_to(:action => 'view_admins')
end
  def view_members
    subquery = Reservation.select("user_id,count(book_id) as reservation_count").where(:dateReturned =>nil).
                          group('user_id')
    @active_members = User.select("users.*,reservation_count").
                      joins("LEFT JOIN ((#{subquery.to_sql}) as T) ON users.id=T.user_id").
                      where("isDeleted = ? and role & ? > 0",FALSE,User::IS_MEMBER)
    @active_members.each do |m|
      if m.reservation_count == nil
        m.reservation_count=0
      end
    end
  end
  def delete_members
    del_user = User.where(id: params[:to_be_deleted_members])
    del_user.each do |m|
      if(m.role & User::IS_ADMIN >0)
        m.update(:role => User::IS_ADMIN)
      else
        user_reservation = Reservation.where(:user_id => m.id,:dateReturned => nil)
        if(user_reservation.any? )
          flash[:notice] = "Some members had reservations,they were not deleted"
        else
          m.update(:isDeleted => TRUE)
        end
      end
    end
    redirect_to action: 'view_members'
  end

  def checkouts
    if session[:role] == 1 # Is an admin, we will get the user id from the caller context
      @user = User.find(params[:userId])
    else
      @user = User.find_by_email(session[:email])
    end
    @checkout_history  = Reservation.select("reservations.*,books.*").
        where(user_id: @user.id).
        joins("JOIN books ON reservations.book_id=books.id")
    @user = User.select(:name, :id).where(id: @user.id)
  end

  def return
    reservation_row = Reservation.find_by book_id: params[:book_id], user_id:  params[:user_id],dateReturned: nil
    reservation_row.update(:dateReturned =>  Time.now.getutc)

    nextWaitlist = Waitlist.order(created_at: :asc).find_by_book_id(params[:book_id])

    book = Book.find params[:book_id]
    if(nextWaitlist.nil?)
      book.update(status: :available)
    else
      reservation = Reservation.create(user_id: nextWaitlist.user_id, book_id: nextWaitlist.book_id, dateIssued: Time.now.getutc);
      Waitlist.destroy(nextWaitlist.id)
      user = User.find(nextWaitlist.user_id)
      WaitlistMailer.waiting_clear_notification(user,book).deliver
    end
    redirect_to action: 'checkouts', userId: params[:user_id]
   end

end


