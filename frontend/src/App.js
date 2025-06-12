import React, { useState, useCallback } from 'react';
import { useDropzone } from 'react-dropzone';
import axios from 'axios';

function App() {
  const [uploading, setUploading] = useState(false);
  const [uploadProgress, setUploadProgress] = useState(0);
  const [uploadResult, setUploadResult] = useState(null);
  const [error, setError] = useState('');

  const onDrop = useCallback(acceptedFiles => {
    if (acceptedFiles.length === 0) return;
    
    const file = acceptedFiles[0];
    uploadFile(file);
  }, []);

  const { getRootProps, getInputProps, isDragActive } = useDropzone({
    onDrop,
    multiple: false,
    accept: {
      'image/*': ['.jpeg', '.jpg', '.png', '.gif'],
      'application/pdf': ['.pdf'],
      'application/msword': ['.doc'],
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document': ['.docx'],
      'application/vnd.ms-excel': ['.xls'],
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': ['.xlsx'],
      'application/vnd.ms-powerpoint': ['.ppt'],
      'application/vnd.openxmlformats-officedocument.presentationml.presentation': ['.pptx'],
      'text/plain': ['.txt']
    },
    maxSize: 100 * 1024 * 1024 // 100MB
  });

  const uploadFile = async (file) => {
    const formData = new FormData();
    formData.append('file', file);

    setUploading(true);
    setError('');
    setUploadResult(null);

    try {
      const response = await axios.post('/upload', formData, {
        headers: {
          'Content-Type': 'multipart/form-data',
        },
        onUploadProgress: (progressEvent) => {
          const progress = Math.round(
            (progressEvent.loaded * 100) / progressEvent.total
          );
          setUploadProgress(progress);
        },
      });

      setUploadResult(response.data);
    } catch (err) {
      setError(err.response?.data?.error || 'Error uploading file');
      console.error('Upload error:', err);
    } finally {
      setUploading(false);
    }
  };

  return (
    <div className="min-h-screen bg-gray-100 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md mx-auto bg-white rounded-xl shadow-md overflow-hidden md:max-w-2xl p-6">
        <div className="text-center mb-8">
          <h1 className="text-2xl font-bold text-gray-900">File Upload</h1>
          <p className="mt-2 text-sm text-gray-600">
            Upload your files here
          </p>
        </div>

        <div 
          {...getRootProps()} 
          className={`border-2 border-dashed rounded-lg p-8 text-center cursor-pointer transition-colors ${
            isDragActive ? 'border-blue-500 bg-blue-50' : 'border-gray-300 hover:border-blue-400'
          }`}
        >
          <input {...getInputProps()} />
          {isDragActive ? (
            <p className="text-blue-600">Drop the file here ...</p>
          ) : (
            <div>
              <p className="text-gray-700">
                Drag 'n' drop a file here, or click to select a file
              </p>
              <p className="text-xs text-gray-500 mt-2">
                Supported formats: Images, PDF, Word, Excel, PowerPoint, Text
              </p>
              <p className="text-xs text-gray-500">
                Max file size: 100MB
              </p>
            </div>
          )}
        </div>

        {uploading && (
          <div className="mt-6">
            <div className="w-full bg-gray-200 rounded-full h-2.5">
              <div 
                className="bg-blue-600 h-2.5 rounded-full" 
                style={{ width: `${uploadProgress}%` }}
              ></div>
            </div>
            <p className="text-sm text-gray-600 mt-2 text-center">
              Uploading: {uploadProgress}%
            </p>
          </div>
        )}

        {error && (
          <div className="mt-6 p-4 bg-red-50 border-l-4 border-red-500">
            <p className="text-red-700">{error}</p>
          </div>
        )}

        {uploadResult && (
          <div className="mt-6 p-4 bg-green-50 border-l-4 border-green-500">
            <p className="text-green-700 font-medium">Upload successful!</p>
            <div className="mt-2 text-sm text-gray-700">
              <p>File: {uploadResult.file.originalname}</p>
              <p>Size: {(uploadResult.file.size / 1024 / 1024).toFixed(2)} MB</p>
              <p>Type: {uploadResult.file.mimetype}</p>
            </div>
          </div>
        )}
      </div>
    </div>
  );
}

export default App;
