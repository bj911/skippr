class HomeController < ApplicationController
  require 'date'
  before_filter :set_client, except: :index

  def index
  end

  def search_info
    @users = @client.user_search(params[:search])
    @tags = @client.tag_search(params[:search])
  end

  def show_info
    @search_type = params[:search_type]
    @search_item = @client.send(@search_type, params[:id])
    min_timestamp = 1.week.ago.to_time.to_i

    @media_likes = @client.send("#{@search_type}_recent_media".to_sym, params[:id], min_timestamp: min_timestamp, count: 10)
    @media_comments = @media_likes.dup

    @media_comments.delete_if{|media| media.comments[:count] == 0 or media.comments[:data].first[:created_time].to_i < min_timestamp}
    @media_likes.delete_if{|media| media.likes[:count] == 0 }
  end

  private

  def set_client
    @client = Instagram.client
  end

end
