class MembersController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @members = Member.all
    respond_to do |format|
      format.json {render json: {members: @members}, status: :ok }
    end
  end 

  def show
    begin
      @member = Member.find(params[:id])
      respond_to do |format|
        format.json {render json: {member: @member}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      respond_to do |format|
        format.json {render json: {member: @member}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {error: @member.errors}, status: :unprocessable_entity}
      end
    end
  end 

  def update
    begin
      @member = Member.find(params[:id]) 
      if @member.update(member_params)  
        respond_to do |format|
          format.json {render json: {member: @member}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @member.errors}, status: :unprocessable_entity}
        end
      end   
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end    
  end
  
  def destroy
    begin
      @member = Member.find(params[:id])
      @member.destroy
      respond_to do |format|
        format.json {render json: {message: 'Successfully deleted'}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found}
      end
    end
  end

  private
    def member_params
      params.require(:member).permit(:name, :address, :phone_no, :gender, :code, :validity_date, :is_author, :library_id)
    end
end