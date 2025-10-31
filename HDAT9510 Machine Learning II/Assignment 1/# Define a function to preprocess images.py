# Define a function to preprocess images and their labels with augmentation
def preprocess_image_label(image_path, label):
    image = preprocess_and_augment_image2(image_path)
    return image, (image, tf.one_hot(label, depth=3))



# Shuffle the data
combined = list(zip(multi_class_image_paths, multi_class_labels))
random.shuffle(combined)
multi_class_image_paths, multi_class_labels = zip(*combined)

# Create a TensorFlow dataset from image paths and labels
multi_class_dataset = tf.data.Dataset.from_tensor_slices((list(multi_class_image_paths), list(multi_class_labels)))

# Define a function to preprocess images and their labels with augmentation
def preprocess_image_label(image_path, label):
    image = preprocess_and_augment_image2(image_path)
    return image, (image, tf.one_hot(label, depth=3))

# Map the preprocessing function to the dataset
multi_class_dataset = multi_class_dataset.map(preprocess_image_label)

# Batch the dataset
batch_size = 128
multi_class_dataset = multi_class_dataset.batch(batch_size)

print(f"Total multi-class sampled images: {len(multi_class_image_paths)}")


