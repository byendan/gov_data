var Apod = React.createClass({

  render() {
    const title = this.props.apodModule.title;
    const description = this.props.apodModule.description;
    const imgUrl = this.props.apodModule.img_url;

    return (
      
      <div className="apod-full-area">

        <div className="row">
          <div className="apod-name">
            <h3>{title}</h3>
          </div>
        </div>

        <div className="row apod-img-desc">
          <div className="apod-image-area col s6">
            <img className="responsive-img materialboxed" src={imgUrl} />
          </div>

          <div className="apod-description col s6 right">
            <p>{description}</p>
          </div>
        </div>

      </div>
    )
  }
});
