var PostApod = React.createClass({

  render() {

    return (

      <div className="post-apod">
        <div className="container">
          <div className="row">
            <div className="col s10 offset-s1 apod-info">
              <p>Above is an example using the API for NASA Astronomical Picture Of the Day,
                or APOD. Everyday a new amazing picture of Earth and beyond. You can read
                more about their API's <a target="_blank" href="https://api.nasa.gov/api.html">here</a></p>
            </div>
          </div>
        </div>
      </div>

    )
  }
});
