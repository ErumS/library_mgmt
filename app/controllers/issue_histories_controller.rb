class IssueHistoriesController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
    @issue_histories = IssueHistory.all
    respond_to do |format|
      format.json {render json: {issue_histories: @issue_histories}, status: :ok }
    end
  end 

  def show
    begin
      @issue_history = IssueHistory.find(params[:id])
      respond_to do |format|
        format.json {render json: {issue_history: @issue_history}, status: :ok}
      end
    rescue => e
      respond_to do |format|
        format.json {render json: {error: e.message}, status: :not_found} 
      end
    end
  end

  def create
    @issue_history = IssueHistory.new(issue_history_params)
    if @issue_history.save
      respond_to do |format|
        format.json {render json: {issue_history: @issue_history}, status: :ok}
      end
    else
      respond_to do |format|
        format.json {render json: {error: @issue_history.errors}, status: :unprocessable_entity}
      end
    end
  end 

  def update
    begin
      @issue_history = IssueHistory.find(params[:id]) 
      if @issue_history.update(issue_history_params)  
        respond_to do |format|
          format.json {render json: {issue_history: @issue_history}, status: :ok}
        end
      else
        respond_to do |format|
          format.json {render json: {error: @issue_history.errors}, status: :unprocessable_entity}
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
      @issue_history = IssueHistory.find(params[:id])
      @issue_history.destroy
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
    def issue_history_params
      params.require(:issue_history).permit(:member_id, :book_ids, :issue_date, :return_date, :copies)
    end
end