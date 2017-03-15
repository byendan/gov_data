var Rover = React.createClass({

  render() {

    return (
      <div className="front-page-rover-area">
        <div className="row rover-title-row">
          <div className="col s6">
            <h3>Mars Rover Pictures</h3>
          </div>
        </div>
        <div className="row">
          <div className="col s6">
            <p>Search for pictures from Curiosity, Spirit, and Opportunity</p>
          </div>
          <div className="col s6">

            <a href="/rover_modules/new" className="btn" >Search Rovers</a>
          </div>
        </div>
      </div>
    )
  }

});
