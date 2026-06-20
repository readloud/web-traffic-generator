class DomainsController < ApplicationController
  before_action :set_domain, only: [:show, :next, :edit, :update, :destroy, :update_urls_status]

  # GET /domains
  # GET /domains.json
  def index
    @statuses   = Status.all
    session[:all_domains] = search_domains(params).pluck(:id)
    @domains = search_domains(params).page params[:page]
  end

  # GET /domains/1
  # GET /domains/1.json
  def show
    @next_domain = nil
    if session[:all_domains] && session[:all_domains].index(params[:id].to_i)
      next_index = session[:all_domains].index(params[:id].to_i).next
      @next_domain = session[:all_domains][next_index]
    end
    @statuses = Status.all
    @urls = @domain.urls.page params[:page]
  end

  # GET /domains/new
  def new
    @domain = Domain.new
  end

  # GET /domains/1/edit
  def edit
  end

  # POST /domains
  # POST /domains.json
  def create
    @domain = Domain.new(domain_params)

    respond_to do |format|
      if @domain.save
        format.html { redirect_to @domain, notice: 'Domain was successfully created.' }
        format.json { render action: 'show', status: :created, location: @domain }
      else
        format.html { render action: 'new' }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /domains/1
  # PATCH/PUT /domains/1.json
  def update
    respond_to do |format|
      if @domain.update(domain_params)
        format.html { redirect_to @domain, notice: 'Domain was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.json
  def destroy
    @domain.destroy

    respond_to do |format|
      format.html { redirect_to domains_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_domain
    @domain = Domain.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def domain_params
    params.require(:domain).permit(:url, :status_id)
  end

  # Search domains by term and status
  def search_domains(params)
    status_id   = params[:status_id].to_s.strip
    search_term = params[:search].to_s.strip

    if search_term
      if status_id.empty?
        Domain.where('url like ?', "%#{search_term}%")
      else
        Domain.where('url like ? AND status_id = ?', "%#{search_term}%", status_id)
      end
    else
      Domain.all
    end
  end

end
