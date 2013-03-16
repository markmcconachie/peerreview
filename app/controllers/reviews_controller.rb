class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  def create
    @review = Review.new(review_params)

    role = @review.member.role
    questions = Question.where(fromrole: role)

    #todo
    teamMembers = Member.where(team_id: @review.member.team_id)

    questions.each do |question|
      #TODO 
      a = Answer.create({ from_member_id: @review.member.id, for_member_id: @review.member.id, question: question});
      @review.answers << a
    end

    if @review.save
      redirect_to controller: 'reviews', action: 'fill_out_review', id: @review.id
    else
      render action: 'new'
    end
  end

  def fill_out_review
    @review = Review.find(params[:id])
  end

  # PATCH/PUT /reviews/1
  def update
    if @review.update(review_params)
      redirect_to @review, notice: 'Review was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /reviews/1
  def destroy
    @review.destroy
    redirect_to reviews_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:member_id, answers_attributes: [:text, :id])
    end
end