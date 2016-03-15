
class UserimporterController < ApplicationController

  before_filter :curator_required, :only => [:import]

  def new_batch_csv
    if params[:upload].blank? || params[:upload] && params[:upload][:datafile].blank?
      flash[:error] = "You must select a CSV file to upload."
      return redirect_to :action => "import"
    end

    # Copy to a temp directory
    path = private_page_cache_path(File.join(
        "bulk_user_files",
        "#{current_user.login}-#{Time.now.to_i}-#{params[:upload]['datafile'].original_filename}"
    ))
    FileUtils.mkdir_p File.dirname(path), :mode => 0755
    File.open(path, 'wb') { |f| f.write(params[:upload]['datafile'].read) }

    # Send the filename to a background processor
    Delayed::Job.enqueue(BulkUserFile.new(path, current_user), :queue => "slow", :priority => USER_PRIORITY)

    # Notify the user that it's getting processed and return them to the upload screen.
    flash[:notice] = 'Users file has been queued for import.'
    #redirect_to :import_users_path
    redirect_to :action => "import"
  end

  def import
    if request.get?
      render "users/import"
    else
      new_batch_csv
    end
  end

end