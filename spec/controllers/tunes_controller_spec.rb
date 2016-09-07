require 'rails_helper'

RSpec.describe TunesController, type: :controller do
  # This should return the minimal set of attributes required to create
  # a valid Tune. As you add validations to Tune, be sure to
  # adjust the attributes here as well.
  #
  let(:valid_attributes) { attributes_for(:tune) }
  let(:invalid_attributes) { attributes_for(:tune, song_title: nil) }

  describe "GET #index", viewing: true do
    after(:all) { Tune.destroy_all }

    before(:all) do
      song_library = [
        { game_title: "Assassin's Creed",
          song_title: "Ezio's Family",
          youtube_video_id: "youtube.com/watch?v=dSCq7jTL7tQ",
          views: 0 },
        { game_title: "Zssassin's Creed",
          song_title: "Azio's Family",
          youtube_video_id: "youtube.com/watch?v=dSCq7jTL7tZ",
          views: 5 },
        { game_title: "Mssassin's Creed",
          song_title: "Zzio's Family",
          youtube_video_id: "youtube.com/watch?v=dSCq7jTL7td",
          views: 11 }
      ]
      song_library.each do |song|
        create(
          :tune,
          game_title: song[:game_title],
          song_title: song[:song_title],
          youtube_video_id: song[:youtube_video_id],
          views: song[:views]
        )
      end
    end

    it "assigns all tunes as @tunes" do
      get :index, {}
      expect(assigns(:tunes).count).to eq(3)
    end

    it "renders the index view" do
      get :index, {}
      expect(response).to render_template(:index)
    end

    describe "sorting", sorting: true do
      it "assigns tunes in the default order when no sort is chosen" do
        get :index, {}
        expect(assigns(:tunes)
          .map(&:song_title))
          .to eq(["Ezio's Family", "Azio's Family", "Zzio's Family"])
      end

      it "assigns tunes in A-Z game_title order when by_game is chosen" do
        get :index, sort_scope: "by_game"
        expect(assigns(:tunes)
          .map(&:game_title))
          .to eq(["Assassin's Creed", "Mssassin's Creed", "Zssassin's Creed"])
      end

      it "assigns tunes in A-Z song_title order when by_song is chosen" do
        get :index, sort_scope: "by_song"
        expect(assigns(:tunes)
          .map(&:song_title))
          .to eq(["Azio's Family", "Ezio's Family", "Zzio's Family"])
      end

      it "assigns tunes in view count order when most_viewed is chosen" do
        get :index, sort_scope: "most_viewed"
        expect(assigns(:tunes)
          .map(&:views))
          .to eq([11, 5, 0])
      end
    end
  end

  describe "GET #new", adding: true do
    it "assigns a new tune as @tune" do
      get :new, {}
      expect(assigns(:tune)).to be_a_new(Tune)
    end
  end

  describe "GET #edit", editing: true do
    it "assigns the requested tune as @tune" do
      tune = create(:tune, valid_attributes)
      get :edit, id: tune.to_param
      expect(assigns(:tune)).to eq(tune)
    end
  end

  describe "POST #create", adding: true do
    context "with valid params" do
      it "creates a new Tune" do
        expect { post :create, tune: valid_attributes }
          .to change(Tune, :count).by(1)
      end

      it "assigns a newly created tune as @tune" do
        post :create, tune: valid_attributes
        expect(assigns(:tune)).to be_a(Tune)
      end

      it "it saves the created @tune instance variable" do
        post :create, tune: valid_attributes
        expect(assigns(:tune)).to be_persisted
      end

      it "redirects to the index" do
        post :create, tune: valid_attributes
        expect(response).to redirect_to(tunes_path)
      end
    end

    context "with invalid params" do
      before(:each) { post :create, tune: invalid_attributes }
      it "assigns a newly created but unsaved tune as @tune" do
        expect(assigns(:tune)).to be_a_new(Tune)
      end

      it "re-renders the 'new' template" do
        expect(response).to render_template(:new)
      end

      it "gives a flash fail message" do
        expect(flash[:alert]).to eq "Song not created."
      end
    end
  end

  describe "PUT #update", editing: true do
    context "with valid params" do
      let(:new_attributes) { attributes_for(:tune, song_title: "New Song") }

      it "updates the requested tune" do
        tune = create(:tune, valid_attributes)
        put :update, id: tune.to_param, tune: new_attributes
        tune.reload
        expect(tune.song_title).to eq("New Song")
      end

      it "assigns the requested tune as @tune" do
        tune = create(:tune, valid_attributes)
        put :update, id: tune.to_param, tune: valid_attributes
        expect(assigns(:tune)).to eq(tune)
      end

      it "redirects to the index" do
        tune = create(:tune, valid_attributes)
        put :update, id:  tune, tune: valid_attributes
        expect(response).to redirect_to(tunes_path)
      end
    end

    context "with invalid params" do
      it "assigns the tune as @tune" do
        tune = create(:tune, valid_attributes)
        put :update, id: tune, tune: invalid_attributes
        expect(assigns(:tune)).to eq(tune)
      end

      it "re-renders the 'edit' template" do
        tune = create(:tune, valid_attributes)
        put :update, id: tune.to_param, tune: invalid_attributes
        expect(response).to render_template(:edit)
      end

      it "gives a flash fail message" do
        tune = create(:tune, valid_attributes)
        put :update, id: tune.to_param, tune: invalid_attributes
        expect(flash[:alert]).to eq "Song not updated."
      end
    end
  end

  describe "DELETE #destroy", deleting: true do
    let(:valid_tune) { create(:tune, valid_attributes) }

    it "destroys the requested tune" do
      tune = valid_tune
      expect { delete :destroy, id: tune.to_param }
        .to change(Tune, :count).by(-1)
    end

    it "redirects to the tunes list" do
      tune = valid_tune
      delete :destroy, id: tune.to_param
      expect(response).to redirect_to(tunes_path)
    end
  end
end

# get :index

# params = { id: 123 }
# get :edit, params

# params = { widget: { description: 'Hello World' } }
# # Specify format for AJAX/JS responses
# params.merge!(format: :js)
# (e.g. create.js.erb view)
# post :create, params

# # Testing 404s in controllers (assuming default Rails handling
# # of RecordNotFound)
# expect { delete :destroy, { id: 'unknown' } }
#   .to raise_error(ActiveRecord::RecordNotFound)

# # Rails `:symbolized` status codes at end of each status code page
# # at http://httpstatus.es/
# expect(response).to have_http_status(:success) # 200
# expect(response).to have_http_status(:forbidden) # 403

# expect(response).to redirect_to foo_path
# expect(response).to render_template(:template_filename_without_extension)
# expect(response).to render_template(:destroy)

# # Need response.body? Requires render_views call outside "it" block
# # (see above & read given URL)
# expect(response.body).to match(/Bestsellers/)
# expect(response.body).to include "Bestsellers"

# expect(response.headers["Content-Type"])
#   .to eq "text/html; charset=utf-8"
# expect(response.headers["Content-Type"])
#   .to eq "text/javascript; charset=utf-8"

# # assigns(:foobar) accesses the @foobar instance variable
# # the controller method made available to the view

# # Think of assigns(:widgets) as @widgets in the controller method
# expect(assigns(:widgets)).to eq([widget1, widget2, widget3])

# # Think of assigns(:product) as @product in the controller method
# expect(assigns(:product)).to eq(bestseller)
# # cat.cool is a boolean, google "rspec predicate matchers"
# expect(assigns(:cat)).to be_cool
# expect(assigns(:employee)).to be_a_new(Employee)

# # Asserting flash messages
# expect(flash[:notice]).to eq "Congratulations on buying our stuff!"
# expect(flash[:error]).to eq "Buying our stuff failed :-("
# expect(flash[:alert]).to eq "You didn't buy any of our stuff!!!"

# # Oi Eliot - TODO: add cookies and session examples here

# # Query the db to assert changes persisted
# expect(Invoice.count).to eq(1)

# # Reload from db an object fetched in test setup when its record in db
# # is updated by controller method, otherwise you're testing stale data
# employee.reload
# invoice.reload
# product.reload
# widget.reload
