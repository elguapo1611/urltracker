class PagesController < AuthController
  def index
    @pages = current_user.pages.includes([:dom_selectors, :crawls])
    @pages = @pages.paginate(:page => params[:page], :per_page => 20)
  end

  def run
    # this should be backgrounded.... we should also add a state machine for pending crawls
    @page = current_user.pages.find(params[:id])
    @page.crawl
    redirect_to page_path(@page)
  end

  def show
    @page = current_user.pages.find(params[:id], :include => [:dom_selectors])
    @crawls = @page.crawls.order("created_at DESC").limit(2)
  end

  def edit
    @page = current_user.pages.find(params[:id])
  end

  def update
    @page = current_user.pages.find(params[:id])
    
  end
end
