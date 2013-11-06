enable :sessions
#  GET ===================================

get '/' do
  @posts = Post.all
  erb :index
end

# Display the login page
get '/login' do
  erb :login
end

# Display the page for a given user
get '/user/:id' do
  @user_to_view = User.find(params[:id])
  # @current_user = User.find(session[:user_id])
  erb :user_page
end

# Display all posts made by a given user
get '/user/:id/posts' do
  @user_to_view = User.find(params[:id])
  @current_user = User.find(session[:user_id])
  @posts = @user_to_view.posts
  erb :user_posts_page
end

# Display all comments made by a given user
get '/user/:id/comments' do
  @user_to_view = User.find(params[:id])
  @current_user = User.find(session[:user_id])
  @comments = @user_to_view.comments
  erb :user_comments_page
end

# Display the form to create a new post
get '/post/new' do
  redirect to '/login' if session[:user_id].nil?
  @current_user = User.find(session[:user_id])


  erb :new_post_page
end

get '/post/:id' do
  # @current_user = User.find(session[:user_id])
  @post = Post.find(params[:id])

  @comments = @post.comments
  erb :display_post
end

# Log out the current user
get '/logout' do
  session.clear
  redirect to '/'
end



# POST =========================================

# Login
post '/login' do
  session.clear
  # @user = User.where("email = ?", params[:email]).first
  # @user = User.find_by_email(params[:email])
  @user = User.authenticate(params[:email], params[:password])

  if @user.nil?
    erb :login
  else
    session[:user_id] = @user.id

    redirect to "/user/#{@user.id}"
  end
end

# Create a new user
post '/create_user' do
  @new_user = User.create(name: params[:name], email: params[:email], password: params[:password])
  session[:user_id] = @new_user.id

  redirect to "/user/#{@new_user.id}"
end

# Create a new post
post '/post/new' do
  redirect to '/login' if session[:user_id].nil?

  @current_user = User.find(session[:user_id])

  post = Post.create(:title => params[:title], :link_text => params[:link])
  @current_user.posts << post
  @current_user.save

  redirect to "/post/#{post.id}"
end

post '/post/:id/comment/new' do
  redirect to '/login' if session[:user_id].nil?

  @current_user = User.find(session[:user_id])

  @post = Post.find(params[:id])

  @comment = Comment.create(:text => params[:comment_text])

  @current_user.comments << @comment
  @current_user.save

  @post.comments << @comment
  @post.save

  redirect to "/post/#{@post.id}"
end



















