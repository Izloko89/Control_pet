class ItemCategoriesController < ApplicationController
  before_action :check_admin_user, only: [:edit, :create, :update, :destroy]
  before_action :set_item_category, only: [:show, :edit, :update, :destroy]

  # GET /item_categories
  # GET /item_categories.json
  def index
    @item_categories = ItemCategory.paginate(:page => params[:page], :per_page => 20).where(:user_id => current_user.user_id)
  end

  # GET /item_categories/1
  # GET /item_categories/1.json
  def show
  end

  # GET /item_categories/new
  def new
    @item_category = ItemCategory.new
  end

  # GET /item_categories/1/edit
  def edit
  end

  # POST /item_categories
  # POST /item_categories.json
  def create
    @item_category = ItemCategory.new(item_category_params)
    @item_category.user_id = current_user.user_id
      respond_to do |format|
        if @item_category.save
          format.html { redirect_to :back, notice: 'Se ha creado la categoria' }
          format.json { render action: 'show', status: :created, location: @item_category }    
        else
          format.html { render action: 'new' }
          format.json { render json: @item_category.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /item_categories/1
  # PATCH/PUT /item_categories/1.json
  def update
      respond_to do |format|
      if @item_category.update(item_category_params)
        format.html { redirect_to @item_category, notice: 'se ha actualizado la categoría' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_categories/1
  # DELETE /item_categories/1.json
  def destroy
    @item_category.destroy
    respond_to do |format|
      format.html { redirect_to item_categories_url }
      format.json { head :no_content }
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_category
      @item_category = ItemCategory.find(params[:id])

    end

    def check_admin_user
    unless current_user.is_admin || current_user.can_update_items
      flash[:alert] = "No tienes los permisos"
      redirect_to :back
    end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_category_params
      params.require(:item_category).permit(:name, :description)
    end

end
