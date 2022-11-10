require 'kimurai'
require 'json'

class Api::V1::ItemsController < ApplicationController
  def list
    response = ReposSpider.process()

    if response[:status] == :completed && response[:error].nil?  
      render json: JSON.pretty_generate(ReposSpider.list)
    else
      render json: { status: "error", message: "Unable to scrape data from this website..." }
    end
  rescue StandardError => e
    render json: { status: "error", message: "Error: #{e}" }
  end

  def search
    query = params[:q]
    puts query

    response = RepoSearchSpider.process(query)

    if response[:status] == :completed && response[:error].nil?  
      render json: JSON.pretty_generate(RepoSearchSpider.list)
    else
      render json: { status: "error", message: "Unable to scrape data from this website..." }
    end
  rescue StandardError => e
    render json: { status: "error", message: "Error: #{e}" }
  end
  
end