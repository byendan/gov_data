var Body = React.createClass({



  render() {
    return(
      <div>
        <SiteIntro />
        <Apod apodModule={this.props.apodModule} />
        <PostApod />
        <Rover />
      </div>
    )
  }
});
