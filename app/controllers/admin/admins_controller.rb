class Admin::AdminsController < AdminController
  before_action :set_admin, only: [:destroy, :edit, :update]

  def index
    page_limit = 13
    @admins = Admin.order("name").page(params['page']).per(page_limit)
    @pagination_windows = 3
    @title = "Admininstradores"
  end

  def new
    @admin = Admin.new
    @title = "Cadastrar Administrador"
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      redirect_to admin_admins_path,
      notice: helpers.alert_success('Administrador criado com êxito.')
    else
      render :new
    end
  end

  def edit
    @admin = Admin.find(params[:id])
    @title = "Alterar Administrador"
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update(admin_params_edit)
      redirect_to admin_admins_path,
      notice: helpers.alert_success('Administrador editado com êxito.')
    else
      flash.now[:alert] = 'Member not updated'
      render 'edit'
    end
  end

  def my_requests
    @admin = current_user
  end

  def destroy
    user = Admin.find(params[:id])
    if current_admin == user
      redirect_to admin_admins_path,
      notice: helpers.alert_danger('Você não pode se excluir.')
    else
      @admin.destroy
      redirect_to admin_admins_path,
      notice: helpers.alert_success('Administrador excluído com êxito.')
    end
  end

    private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end

  def admin_params_edit
    params.require(:admin).permit(:name, :email)
  end
end
