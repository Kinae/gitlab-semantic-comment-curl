#/bin/zsh

# create a token in gitlab with "api" permissions
GRAPHQL_TOKEN=

name=(
  "praise (éloge)"
  "nitpick (chipoter)"
  "suggestion (suggesion)"
  "issue (problème)"
  "todo (à faire)"
  "question (question)"
  "thought (réflexion)"
  "chore (tâche)"
  "note (note)"
  "typo (coquille)"
)

content=(
  "**praise (\"non-blocking,blocking,if-minor\"):** [subject]"
  "**nitpick (\"non-blocking,blocking,if-minor\"):** [subject]"
  "**suggestion (\"non-blocking,blocking,if-minor\"):** [subject]"
  "**issue (\"non-blocking,blocking,if-minor\"):** [subject]"
  "**todo (\"non-blocking,blocking,if-minor\"):** [subject]"
  "**question (\"non-blocking,blocking,if-minor\"):** [subject]"
  "**thought (\"non-blocking,blocking,if-minor\"):** [subject]"
  "**chore (\"non-blocking,blocking,if-minor\"):** [subject]"
  "**note (\"non-blocking,blocking,if-minor\"):** [subject]"
  "**typo (\"non-blocking,blocking,if-minor\"):** [subject]"
)

for ((i = 0; i < ${#name[@]}; i++)); do
  json_data=$(jq -n --arg name "${name[i]}" --arg content "${content[i]}" '{"operationName":"savedReplyCreate","variables":{"name":$name,"content":$content},"query":"mutation savedReplyCreate($name: String!, $content: String!) { savedReplyMutation: savedReplyCreate(input: {name: $name, content: $content}) { errors savedReply { id name content __typename } __typename } }"}')
  curl -X POST "https://gitlab.com/api/graphql" -H "Authorization: Bearer $GRAPHQL_TOKEN" -H "Content-Type: application/json" --data "$json_data"
  echo
done