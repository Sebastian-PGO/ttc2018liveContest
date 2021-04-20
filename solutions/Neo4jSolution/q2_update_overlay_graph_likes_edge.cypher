UNWIND $likesEdgeIds AS likesEdgeId
MATCH (u1:User)-[likesEdge]->(c:Comment)
WHERE id(likesEdge) = likesEdgeId
SET c:Dirty
WITH u1, c
MATCH (u1)<-[friendEdge:FRIEND]->(u2:User)
      -[:LIKES]->(c)
WITH c, startNode(friendEdge) AS uStart, endNode(friendEdge) AS uEnd
CREATE (uStart)-[:FRIEND_WHO_LIKES_COMMENT {commentId: c.id}]->(uEnd)