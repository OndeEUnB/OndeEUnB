class Admin::PlansController < AdminController
  before_action :set_plans, only: [:destroy, :edit, :update]
  before_action :set_buildings, only: [:new, :edit, :update, :create]

  def index
    page_limit = 13
    @plans = Plan.order("building_id").
      includes(:building).
      page(params['page']).
      per(page_limit)
    @pagination_windows = 3
    @title = 'Plantas'
    @new_url = new_admin_plan_path
  end

  def new
    @plan = Plan.new
    @title = 'Cadastrar Planta'
  end

  def edit
    @title = 'Alterar Planta'
  end

  def update
    if @plan.update(plans_params)
      redirect_to admin_plans_path, notice: helpers.alert_success('Planta editada com êxito.')
    else
      render :edit
    end
  end

  def create
    @plan = Plan.new(plans_params)
    if @plan.save
      redirect_to admin_plans_path, notice: helpers.alert_success('Planta cadastrada com êxito.')
    else
      render :new
    end
  end

  def destroy
    @plan.destroy
    redirect_to admin_plans_path, notice: helpers.alert_success('Planta excluída com êxito.')
  end

  private

  def set_buildings
    @buildings = Building.all
  end

  def set_plans
    @plan = Plan.find(params[:id])
  end

  def plans_params
    params.require(:plan).permit(:building_id, :level, :geo_data, :image)
  end
end
