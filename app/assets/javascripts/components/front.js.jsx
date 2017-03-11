var Front = React.createClass({
  getInitialState() {
    return { apodModule: this.props.data }
  },


  render() {
    return (
      <div>
        <Body apodModule={this.state.apodModule} />
      </div>
    )
  }
});
