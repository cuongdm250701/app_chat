class GroupChannel < ApplicationCable::Channel

    def subscribed
        stream_from "comment_#{params[:group_id]}"
    end
end