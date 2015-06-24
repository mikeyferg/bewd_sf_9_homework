class RecordLabelsController < ApplicationController
  def index
    @record_labels = RecordLabel.all
  end

  def show
    @label = find_label
    @artists = Artist.where(record_label_id: params[:id])
  end

private
  def find_label
    @record_label = RecordLabel.find(params[:id])
  end
  def label_params
    params.require(:record_label).permit(:name)
  end
end
