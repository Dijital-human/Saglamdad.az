"use client";

// Contact Page Component
// /az/ Əlaqə səhifəsi komponenti - email və telefon əlaqə məlumatları
// /en/ Contact page component - email and phone contact information

import { useEffect, useState } from "react";
import { motion } from "framer-motion";
import { Mail, Phone } from "lucide-react";

export default function ContactPage() {
  const [contact, setContact] = useState({ email: "", phone: "" });
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchContact();
  }, []);

  const fetchContact = async () => {
    try {
      const res = await fetch("/api/contact");
      const data = await res.json();
      setContact(data);
    } catch (error) {
      console.error("Error fetching contact:", error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen py-16 md:py-24 bg-gradient-to-br from-primary-50 to-white">
      <div className="container mx-auto px-4 max-w-4xl">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.6 }}
          className="text-center"
        >
          <h1 className="text-4xl md:text-5xl font-bold text-gray-900 mb-8">
            Əlaqə
          </h1>
          <p className="text-xl text-gray-600 mb-12">
            Bizimlə əlaqə saxlayın
          </p>

          {loading ? (
            <div className="flex justify-center items-center py-20">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
            </div>
          ) : (
            <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
              {contact.email && (
                <motion.a
                  href={`mailto:${contact.email}`}
                  initial={{ opacity: 0, scale: 0.9 }}
                  animate={{ opacity: 1, scale: 1 }}
                  transition={{ duration: 0.5 }}
                  className="bg-white p-8 rounded-lg shadow-lg hover:shadow-xl transition-shadow group"
                >
                  <div className="flex flex-col items-center">
                    <div className="bg-primary-100 p-4 rounded-full mb-4 group-hover:bg-primary-200 transition-colors">
                      <Mail className="w-8 h-8 text-primary-600" />
                    </div>
                    <h3 className="text-xl font-semibold text-gray-900 mb-2">
                      Email
                    </h3>
                    <p className="text-primary-600 font-medium break-all">
                      {contact.email}
                    </p>
                  </div>
                </motion.a>
              )}

              {contact.phone && (
                <motion.a
                  href={`tel:${contact.phone}`}
                  initial={{ opacity: 0, scale: 0.9 }}
                  animate={{ opacity: 1, scale: 1 }}
                  transition={{ duration: 0.5, delay: 0.1 }}
                  className="bg-white p-8 rounded-lg shadow-lg hover:shadow-xl transition-shadow group"
                >
                  <div className="flex flex-col items-center">
                    <div className="bg-primary-100 p-4 rounded-full mb-4 group-hover:bg-primary-200 transition-colors">
                      <Phone className="w-8 h-8 text-primary-600" />
                    </div>
                    <h3 className="text-xl font-semibold text-gray-900 mb-2">
                      Telefon
                    </h3>
                    <p className="text-primary-600 font-medium">
                      {contact.phone}
                    </p>
                  </div>
                </motion.a>
              )}

              {!contact.email && !contact.phone && (
                <div className="col-span-2 text-center py-20 bg-white rounded-lg shadow-lg">
                  <p className="text-gray-500 text-lg">
                    Əlaqə məlumatları əlavə olunmayıb
                  </p>
                </div>
              )}
            </div>
          )}
        </motion.div>
      </div>
    </div>
  );
}

