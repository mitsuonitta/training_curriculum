class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getweek
    @plan = Plan.new
  end

  # 予定の保存
  def create
    plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:calendars).permit(:date, :plan)
  end

  def getWeek
    days = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @today_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @today_date..@today_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end
      days = { :month: (@today_date + x).month, :date: (@today_date + x).day, :plans: today_plans}
      @week_days.push(days)
    end
  end
end