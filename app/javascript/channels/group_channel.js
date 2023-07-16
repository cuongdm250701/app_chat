import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', () => {
    const groupLinks = document.querySelectorAll('.group-link');
    groupLinks && groupLinks.forEach((link) => {
      link.addEventListener('click', (event) => {
        const groupId = link.dataset.groupId;
        consumer.subscriptions.create({ channel: 'GroupChannel', group_id: groupId }, {
          received(data) {
            const commentZone = document.querySelector('.comments');
            const CommentContent = 
           `
            <h6 class=${data.content_user}> ${data.send_by} </h6>
            <p class=${data.content_user}> ${data.content} </p>
          `;
           commentZone.innerHTML = commentZone.innerHTML + CommentContent;
          }
        })
      })
    })
  })
  
