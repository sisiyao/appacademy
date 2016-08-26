class Api::BenchesController < ApplicationController
  def index
    @benches = Bench.all
  end

  def create
    @bench = Bench.new(bench_params)
    @bench.save!
  end

  private

  def bench_params
    params.require(:bench).permit(:lat, :lng, :description)
  end
end
