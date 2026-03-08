const GRAPHQL_ENDPOINT = 'http://localhost:8000/graphql';

export const graphqlRequest = async (
  query: string,
  variables?: Record<string, unknown> | null
) => {
  const res = await fetch(GRAPHQL_ENDPOINT, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ query, variables: variables ?? undefined }),
  });

  const json = await res.json();
  if (json.errors) {
    throw new Error(json.errors.map((e: any) => e.message).join(', '));
  }

  return json.data;
};
