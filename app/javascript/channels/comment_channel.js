import consumer from "./consumer"

consumer.subscriptions.create({ channel: "CommentChannel"}, {
  received(data) {
    console.log('data', data)
    const commentZone = document.querySelector('.comments');
    const CommentContent = 
    `
    <p class=${data.content_user}> ${data.content} </p>
    `;
    commentZone.innerHTML = commentZone.innerHTML + CommentContent;
  },
})