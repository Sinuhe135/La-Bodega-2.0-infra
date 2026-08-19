exports.handler = async (event, context) => {
	console.log("Lambda invoked", { event });

	return {
		statusCode: 200,
		body: JSON.stringify({
			message: "Hello from AWS Lambda!",
		}),
	};
};