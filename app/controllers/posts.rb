class Posts < Application
  before :ensure_authenticated, :exclude => [:show, :index]
  provides :xml

  def index
    @posts = Post.all.reverse
    display @posts
  end

  def admin
    
  end
  
  def show(id)
    @post = Post.get(id)
    raise NotFound unless @post
    display @post
  end

  def new
    only_provides :html
    @post = Post.new
    display @post
  end

  def edit(id)
    only_provides :html
    @post = Post.get(id)
    raise NotFound unless @post
    display @post
  end

  def create(post)
    @post = Post.new(post)
    if @post.save
      redirect resource(@post), :message => {:notice => "Post was successfully created"}
    else
      message[:error] = "Post failed to be created"
      render :new
    end
  end

  def update(id, post)
    @post = Post.get(id)
    raise NotFound unless @post
    if @post.update_attributes(post)
       redirect resource(@post)
    else
      display @post, :edit
    end
  end

  def delete(id)
    @post = Post.get(id)
    raise NotFound unless @post
    if @post.destroy
      redirect resource(:posts)
    else
      raise InternalServerError
    end
  end

end # Posts
