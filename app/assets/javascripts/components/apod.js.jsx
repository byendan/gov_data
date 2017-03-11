var Apod = React.createClass({

  render() {
    const title = this.props.apodModule.title;
    const description = this.props.apodModule.description;
    const imgUrl = this.props.apodModule.img_url;
    return (
      <div>
        <div className="title">
          {title}
        </div>

        <div className="description">
          {description}
        </div>

        <div className="img">
          <img src={imgUrl} />
        </div>
      </div>
    )
  }
});
