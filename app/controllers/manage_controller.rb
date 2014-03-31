class ManageController < UserAgentsController
  before_filter :login_required
  
  layout 'default'

  def index
  end

  def edit
    @ua = params[:ua_string]
    
      # record it and get the hit count
      @db  = UserAgent.find :first, :conditions => {:user_agent => @ua} 
      if @db
        render
      else 
        redirect_to '/manage'
      end
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        render
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
end