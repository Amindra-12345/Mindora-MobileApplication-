
const jwt = require('jsonwebtoken');

function authMiddleware(req, res, next) {
  // Get the token from the Authorization header
  const authHeader = req.headers.authorization;

  if (!authHeader || !authHeader.startsWith('Bearer ')) {
    return res.status(401).json({
      success: false,
      message: 'Access denied. Token is required.',
    });
  }

  const token = authHeader.split(' ')[1];

  try {
    // Verify the token using the same secret used during login
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    // Make the verified token data available to the route
    req.user = decoded;

    next();
  } catch (error) {
    return res.status(401).json({
      success: false,
      message: 'Invalid or expired token.',
    });
  }
}

module.exports = authMiddleware;
