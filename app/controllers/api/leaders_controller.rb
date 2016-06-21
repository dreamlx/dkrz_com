class Api::LeadersController < Api::BaseController
  def create
    leader = current_user.leaders.new(leader_params)
    if leader.save
      render nothing: true, status: 201
    else
      return api_error(status: 422)
    end
  end

  private
    def leader_params
      params.permit(
        :name, :phone, :sex, :workplace, :birth,
        :income, :payoff_type, :job, :has_credit_card, :loan_experience,
        :mortgage, :has_car_loan, :has_accumulation_fund,
        :has_life_insurance, :channel
        )
    end
end