class SubnetsController < ApplicationController
  before_action :set_subnet, only: [:show, :destroy]

  # GET /subnets
  # GET /subnets.json
  def index
    @subnets = Subnet.all.domains.page params[:page]
  end

  # GET /subnets/1
  # GET /subnets/1.json
  def show
    @domains = @subnet.domains.page params[:page]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subnet
      @subnet = Subnet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subnet_params
      params.require(:subnet).permit(:ip, :alias)
    end
end
